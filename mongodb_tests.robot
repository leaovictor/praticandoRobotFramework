*** Settings ***
Library   RobotMongoDBLibrary.Insert
Library   RobotMongoDBLibrary.Update
Library   RobotMongoDBLibrary.Find
Library   RobotMongoDBLibrary.Delete
Library   FakerLibrary    
Library   Collections


*** Variables ***
# CONNECT WITH PARAMS
# &{MONGODB_CONNECT_STRING}    host=127.0.0.1   port=27017   username=admin   password=password    database=robotdb     collection=customer

# CONNECT WITH CONNECTION STRING CLUSTER
&{MONGODB_CONNECT_STRING}=   connection=mongodb+srv://leaovic:DjEDIp8L6qMfvcNs@cluster0.fxn5zpb.mongodb.net/    database=robotdb   collection=customer


*** Test Cases ***
Test insert data into mongodb
    ${NAME_FAKE}    FakerLibrary.Name
    ${ADDRESS_FAKE}    FakerLibrary.Address
    ${PHONE_FAKE}    FakerLibrary.Basic Phone Number
    ${ID_FAKE}    FakerLibrary.Uuid 4
    &{DATA}     Create Dictionary    _id=X100001       name=${NAME_FAKE}      address=${ADDRESS_FAKE}     phone=${PHONE_FAKE}
    ${MSG}      InsertOne   ${MONGODB_CONNECT_STRING}    ${DATA}
    Should Be Equal    ${MSG}    INSERTED SUCCESS


Test find by fillter data from mongodb
    &{FILLTER}     Create Dictionary   name=Bill Tran      address=PSC 1351, Box 6650 APO AA 55789
    ${RESULTS}     Find    ${MONGODB_CONNECT_STRING}    ${FILLTER}
    FOR    ${RESULT}    IN    @{RESULTS}
           Log To Console    ${RESULT["phone"]}
    END


Test update data phone into mongodb by ID
    ${PHONE_FAKE}        FakerLibrary.Phone Number
    &{NEWDATA}     Create Dictionary        phone=${PHONE_FAKE}
    ${MSG}        Update         ${MONGODB_CONNECT_STRING}     X100001    ${NEWDATA}
    Should Be Equal    ${MSG}    UPDATED SUCCESS


Test find data by ID from mongodb
    ${RESULTS}     FindOneByID    ${MONGODB_CONNECT_STRING}    X100001
    Log To Console      ${RESULTS}


Test delete data by ID into mongodb
    ${MSG}     DeleteOneByID    ${MONGODB_CONNECT_STRING}        X100001
    Should Be Equal    ${MSG}    DELETED SUCCESS


Populate MongoDB with Fake Data
    [Documentation]    Esse teste popula o banco com dados randômicos
    [Tags]             insert    dados_randomicos    populate    popular
    FOR    ${i}    IN RANGE    10
    ${NAME_FAKE}    FakerLibrary.Name
    ${ADDRESS_FAKE}    FakerLibrary.Address
    ${PHONE_FAKE}    FakerLibrary.Basic Phone Number
    ${ID_FAKE}    FakerLibrary.Uuid 4
    &{DATA}     Create Dictionary    _id=${ID_FAKE}       name=${NAME_FAKE}      address=${ADDRESS_FAKE}     phone=${PHONE_FAKE}
    ${MSG}      InsertOne   ${MONGODB_CONNECT_STRING}    ${DATA}
    Should Be Equal    ${MSG}    INSERTED SUCCESS
    END

# Retrieve and Display Data from MongoDB
#     ${mongodb_connect_string}    Set Variable    mongodb://localhost:27017/mydatabase
#     ${collection}    Set Variable    mycollection
#     ${client}    Connect To MongoDB    ${mongodb_connect_string}
#     ${collection_object}    Get Collection    ${client}    ${collection}
#     ${documents}    Find All    ${collection_object}
#     Log Many    ${documents}