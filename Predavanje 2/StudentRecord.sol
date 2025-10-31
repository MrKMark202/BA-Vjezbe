// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract StudentRecord {
    struct Student {
        string name;
        uint grade;
    }

    mapping(uint => Student) public students;
    uint public count;

    function addStudent(string memory _name, uint _grade) public {
        students[count] = Student(_name, _grade);
        count++;
    }

    function getStudentByName(string memory _name) public view returns (string memory, uint) {
        for (uint i = 0; i < count; i++) {
            if (keccak256(bytes(students[i].name)) == keccak256(bytes(_name))) {
                Student memory s = students[i];
                return (s.name, s.grade);
            }
        }
        revert("Student s tim imenom ne postoji");
    }

    // 🔹 Funkcija za ažuriranje ocjene studenta po imenu
    function updateGrade(string memory _name, uint _newGrade) public {
        bool found = false;
        for (uint i = 0; i < count; i++) {
            if (keccak256(bytes(students[i].name)) == keccak256(bytes(_name))) {
                students[i].grade = _newGrade;
                found = true;
                break;
            }
        }
        require(found, "Student s tim imenom ne postoji");
    }
}
