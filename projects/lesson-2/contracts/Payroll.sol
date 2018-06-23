pragma solidity ^0.4.14;

contract Payroll {

    struct Employee {
        address id;
        uint salary;
        uint lastPayday;
    }

    uint constant payDuration = 10 seconds;

    address owner;
    Employee[] employees;

    function Payroll() payable public {
        owner = msg.sender;
    }
    function _partiaPaid(Employee employee) private{
        uint payment = employee.salary * (now - employee.lastPayday) / payDuration;
        employee.id.transfer(payment);
    }
    
    function _findEmployee(address employeId) private returns (Employee,uint){
        for(uint i = 0; i<employees.length; i++){
            if(employees[i].id == employeId){
                return (employees[i],i);
            }
        }
    }

    function addEmployee(address employeeAddress, uint salary) public {
        require(msg.sender == owner);
        var (employee,index) = _findEmployee(employeeAddress);
        assert(employee.id == 0x0);
        employees.push(Employee(employeeAddress,salary * 1 ether,now));
    }

    function removeEmployee(address employeeId) public {
        require(msg.sender == owner);
        var (employee,index) = _findEmployee(employeeId);
        assert(employee.id != 0x0);
        _partiaPaid(employee);
        delete employees[index];
        employees[index] = employees[employees.length - 1];
        employees.length -= 1;
    }

    function updateEmployee(address employeeAddress, uint salary) public {
        require(msg.sender == owner);
        var (employee,index) = _findEmployee(employeeAddress);
        assert(employee.id != 0x0);
        _partiaPaid(employee);
        employees[index].salary = salary * 1 ether;
        employees[index].lastPayday = now;
    }

    function addFund() payable public returns (uint) {
        return address(this).balance;
    }

    function calculateRunway() public view returns (uint) {
        uint salaryTotal = 0;
        for(uint i = 0;i < employees.length; i++){
            salaryTotal += employees[i].salary;
        }
        return this.balance / salaryTotal;
    }

    function hasEnoughFund() public view returns (bool) {
        return calculateRunway() > 0;
    }

    function getPaid() public {
        var (employee, index) = _findEmployee(msg.sender);
        assert(employee.id != 0x0);
        uint nextPadday = employee.lastPayday + payDuration;
        assert(nextPadday< now);
        employees[index].lastPayday = nextPadday;
        employee.id.transfer(employee.salary);
    }
}
