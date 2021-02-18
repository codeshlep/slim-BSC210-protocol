# slim-BSC210-protocol
Updated and Enhanced Binance Smart-Chain BEP20 Smart Contract Standard Protocol.

Slim-Protocol

Official FutureCoin implementation of the Binance Smart Chain protocol.

Protocol Promotion at https://twitter.com/CoinFTC.
Building compatibility with https://github.com/pancakeswap.
Protocol designed to improve function of https://github.com/binance-chain.
For prerequisites and detailed build instructions please read the installation of the above repositories.

Slim Protocol Installation.
After installation of other packages such as those above.
-> git clone https://github.com/codeshlep/slim-BSC210-protocol -y

Core design

  The BSC210 package builds a single streamline memory object called slim. Slim is a powerful tool built around user contract management and builds many key features into the Binance Smart Chain DApp enviroment. Slim uses classes and mapping to store valuable information such as contract addresses, interest rates, date conditions and more in a compact form.
  
Example usage
   
  * Check the balance of an address: slim.balance[account].

  * Read the trust level of an address: slim.accessLevel[account].
    
  ** DeFi storage has an embedded object, commit.
   
  * Read value of ICO Locked by an address: slim.commit[account].value.

  * Read APR of ICO Locked by an address: slim.commit[account].APR.

#Adding new embedded elements is easy, simply add them to BSC210.sol.
