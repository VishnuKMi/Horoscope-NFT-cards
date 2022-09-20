/**
 * @type import('hardhat/config').HardhatUserConfig
 */
 require('dotenv').config(); 
 require('@nomiclabs/hardhat-ethers');
  
 const {API_URL_KEY, PRIVATE_KEY} = process.env; //environment variables are being loaded here.
  
 module.exports = {
   solidity: "0.8.9",
   defaultNetwork: 'goerli',
   networks: {
     hardhat: {},
     goerli: {
         url: API_URL_KEY,
         accounts: [`0x${PRIVATE_KEY}`]
     }
   }
 };
