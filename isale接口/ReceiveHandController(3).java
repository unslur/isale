package com.isale.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.isale.common.Tools;
import com.isale.dao.IInOrderDao;
import com.isale.dao.IInOrderDetailDao;
import com.isale.dao.ILoginDao;
import com.isale.dao.IProductDao;
import com.isale.dao.ISpaceDao;
import com.isale.dao.ISpaceDetailDao;
import com.isale.dao.IStorageDao;
import com.isale.dao.ITaskDao;
import com.isale.dao.IUserDao;
import com.isale.po.InOrder;
import com.isale.po.InOrderDetail;
import com.isale.po.Product;
import com.isale.po.Space;
import com.isale.po.SpaceDetail;
import com.isale.po.Storage;
import com.isale.po.Task;
import com.isale.po.User;

/**
 * 手持机接口控制层
 */
@Controller
@Scope("prototype")
@RequestMapping("/receiveHand")
@Transactional
public class ReceiveHandController {
	
	@Autowired 
	private ServletContext servletContext;
	@Autowired
	private ILoginDao loginDao;								//登录dao
	@Autowired
	private IUserDao userDao;								//用户dao
	@Autowired
	private ITaskDao taskDao;								//任务dao
	@Autowired
	private IProductDao productDao;							//货品dao
	@Autowired			
	private IInOrderDao inOrderDao;							//入库单dao
	@Autowired
	private IInOrderDetailDao inOrderDetailDao;				//入库明细dao
	@Autowired
	private ISpaceDetailDao spaceDetailDao;					//货位明细dao 
	@Autowired
	private ISpaceDao spaceDao;								//货位dao
	@Autowired
	private IStorageDao storageDao;							//库存dao
	/**
	 * 手持机用户登录
	 */
	@ResponseBody
	@RequestMapping(value="/login")
	public Object login(User form,HttpServletRequest request) throws UnsupportedEncodingException{
		form.setUser_state(1);
		form.setUser_type("2");
		User user = loginDao.login_hand(form);
		if(user != null) {
			user.setUser_loginpass("");
			return user;
		}else{
			return false;
		}
	}
	
	/**
	 * 查询任务类型
	 * @param form findTaskType
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/findTaskType")
	public Task findTaskType(Task form){
		List<Task> taskList = new ArrayList<Task>();
		Task task = null;
		for(int i = 1 ; i <= 5 ; i++){
			task = new Task();
			task.setTask_type(i);
			taskList.add(task);
		}
		form.setTasklist(taskList);
		return form;
	}
	
	/**
	 * 查询用户齐下所有任务
	 * @param form  user_code,task_type,task_state,pager_offset
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/findTaskList")
	public Task findTaskList(Task form){
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(taskDao.findByCount(form));
		form.setTasklist(taskDao.findByList(form));
		return form;
	}
	
	/*************************************入库上架区域开始*********************************/
	/**
	 * 根据任务编码查询任务明细
	 * @param form task_code
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/findTaskDetail")
	public Task updateFindTaskDetail(Task form,SpaceDetail spaceDetail){
		//更新任务状态 处理中
		form.setTask_state(2);
		taskDao.update(form);
		//查询任务下单货品信息
		form.setTask(taskDao.findByCode(form));
		//查询任务下单货品对应上架货位列表
		form.setTasklist(taskDao.findTaskDetail(form));
		//查询任务已上架货品数量
		form.setTask_count_up(spaceDetailDao.findByGroup(spaceDetail));
		return form;
	}
	
	/**
	 * 货品上架实际货位,并写入库存
	 * @param form task_type,task_code,task_othercode(入库明细、出库明细)编码,product_code,product_bulk,task_count,space_code(货位编码)
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/saveStorage")
	public Object saveStorage(Task form,InOrderDetail inOrderDetail,SpaceDetail spaceDetail,Space space,Storage storage,Product product){
		//1：判断扫描的货位是否与入库单类型匹配   1：始发仓货位、2：中转仓成品货位、3：中转仓半成品货位
		inOrderDetail.setInorderdetail_code(form.getTask_othercode());
		inOrderDetail = inOrderDetailDao.findByCode(inOrderDetail);
		if(inOrderDetail == null){
			return false;
		}
		//查询货位类型
		space = spaceDao.findByOther(space);
		if(space == null){
			return false;
		}
		
		if(inOrderDetail.getInorderdetail_halftype() != space.getSpace_halftype()){
			return false;
		}
		
		//2：写入isale_spacedetail
		Tools.setVOToVO(inOrderDetail, spaceDetail);
		spaceDetail.setSpace_halftype(inOrderDetail.getInorderdetail_halftype());
		spaceDetail.setSpace_count(form.getTask_count());
		spaceDetail.setSpace_code(space.getSpace_code());
		spaceDetailDao.insert(spaceDetail);
		
		//3：更新货位信息,计算剩余体积、已用体积、待上架体积
		String bulk = Tools.multiply(product.getProduct_bulk(), form.getTask_count());  //该次绑定货位货品暂用体积
		String space_usedbulk = Tools.addtr(space.getSpace_usedbulk(), bulk);		//货位已用体积
		String space_leftbulk = Tools.subtr(space.getSpace_leftbulk(), bulk);		//货位剩余体积
		space.setSpace_usedbulk(space_usedbulk);
		space.setSpace_leftbulk(space_leftbulk);
		space.setSpace_usestate(2);
		spaceDao.update(space);
		
		//4:根据1：始发仓货位、2：中转仓成品货位、3：中转仓半成品货位 写入/更新货品库存
		storage.setStorage_halftype(inOrderDetail.getInorderdetail_halftype());
		storage = storageDao.findByExist(storage);
		if(storage == null){
			storage = new Storage();
			Tools.setVOToVO(inOrderDetail, storage);
			storage.setStorage_code(Tools.getSystemCode("user"));
			storage.setStorage_count(form.getTask_count());
			storage.setStorage_halftype(inOrderDetail.getInorderdetail_halftype());
			storageDao.insert(storage);
		}else{
			String storage_count = Tools.addtr(storage.getStorage_count(), form.getTask_count());
			storage.setStorage_count(storage_count);
			storageDao.update(storage);
		}
		return form;
	}
	
	/**
	 * 当单次任务待上架数量完毕时候,更新任务状态
	 * @param form task_code,task_state=3 task_othercode
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@ResponseBody
	@RequestMapping(value="/updateTaskState")
	public Object updateTaskState(Task form,InOrderDetail inOrderDetail){
		if(taskDao.update(form) != 0){
			//调用存储,扣减待上架货位对应的体积
			Map map = new HashMap();
			map.put("task_code", form.getTask_code());
			taskDao.updateSpaceUpBulk(map);
			//如果任务对应的入库单齐下任务均已完成,则更新入库明细状态
			Integer count = taskDao.findAllTaskState(form);
			if(count == 0){
				inOrderDetail.setInorderdetail_state(4);
				inOrderDetail.setInorderdetail_code(form.getTask_othercode());
				inOrderDetailDao.update(inOrderDetail);
				//如果子订单对应主订单齐下子单均已完成,则更新主订单状态
				count = inOrderDetailDao.findAllState(inOrderDetail);
				if(count == 0){
					inOrderDetail = inOrderDetailDao.findByCode(inOrderDetail);
					InOrder inOrder = new InOrder();
					inOrder.setInorder_state(2);
					inOrder.setInorder_code(inOrderDetail.getInorder_code());
					inOrderDao.update(inOrder);
				}
			}
			return form;
		}else{
			return false;
		}
	}
	
	/**
	 * 根据任务编码查询已完成上架列表
	 * @param form task_code pager_offset
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/findSpaceDetailList")
	public Object findSpaceDetailList(SpaceDetail form){
		form.setPager_openset(Integer.valueOf(servletContext.getInitParameter("pager_openset")));
		form.setPager_count(spaceDetailDao.findByCount(form));
		form.setSpacedetaillist(spaceDetailDao.findByList(form));
		return form;
	}
	
	/*************************************入库上架区域结束*********************************/
}