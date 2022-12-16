// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract CarPart {
    address public      issuer;
    string  public      issuer_ein;
    string  public      part_category;
    string  public      part_car_origin_year;
    string  public      part_mileage;
    string  public      part_price;
    string  public      crashed_car_base64;
    string  private     serial_number;
    bool    public      is_selled;
    string  public      new_owner_cpf;

    constructor( // createCertificate()
            string memory _issuer_ein,
            string memory _part_category,
            string memory _part_car_origin_year,
            string memory _part_mileage,
            string memory _part_price,
            //string memory _crashed_car_base64,
            string memory _serial_number
    )  {
        issuer = msg.sender;
        issuer_ein = _issuer_ein;
        part_category = _part_category;
        part_car_origin_year = _part_car_origin_year;
        part_mileage = _part_mileage;
        part_price = _part_price;
        //crashed_car_base64 = _crashed_car_base64;
        serial_number = _serial_number;
        is_selled = false;
        new_owner_cpf = '';
    }

    modifier onlyIssuer {
        require(msg.sender == issuer,"Only issuer");
        _;
    }

    function sellCarPart(string memory _new_owner_cpf) public onlyIssuer {
        if (!is_selled) {
            is_selled = true;
            new_owner_cpf = _new_owner_cpf;
        }
    }

    function getSerialNumber() public view onlyIssuer returns (string memory) {
        return serial_number;
    }

    function isThereAlert() public view returns (bool) {
        bytes memory word = bytes(crashed_car_base64);
        return word.length == 0;
    }
}