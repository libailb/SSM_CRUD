package libai.SSM.crud.service;

import java.util.List;

import libai.SSM.crud.dao.DepartmentMapper;
import libai.SSM.crud.bean.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service
public class DepartmentService {
	
	@Autowired
	private DepartmentMapper departmentMapper;

	public List<Department> getDepts() {
		// TODO Auto-generated method stub
		List<Department> list = departmentMapper.selectByExample(null);
		return list;
	}

}
