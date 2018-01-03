# AVT Token Sale

## Update 29 August 2017
Aventus has made changes to the original code by adding white list functionality to make the token sale more fair for our loyal community! We are doubling the Audit Bounty rewards for any vunerabilities reported to us by the end of the week (3 September 2017).

## Notice

This code was written using the [Dappsys](http://dappsys.info) smart contract standard libraries. These libraries have been developed over the last two years by the team behind [MakerDAO](http://makerdao.com), one of the oldest and most ambitious projects in the space. These trusted contracts have been used in numerous deployments on the Ethereum blockchain and beyond, minimizing the amount of purpose-specific code that was written for this token sale. To explore the Dappsys dependencies used in this sale, visit the git submodules of the `lib` folder. 

## General Info

The AVT Token Sale is a simple fixed-price token distribution event. Upon creation, `10,000,000 AVT` are minted by the contract.

`2,000,000 AVT` are sent directly to the founders.

`2,000,000 AVT` will be held in the contract for one year, upon which point they can be claimed by the founders.

`6,000,000 AVT` will be sold by the contract directly to contibutors in exchange for ETH. There will be two periods for the sale, a private stage and a public stage. During the private stage, only one address will be allowed to purchase up to one million AVT at a better price than during the public stage. These are the rates:

**Private Rate:** `1 ETH` to `110 AVT`

**Public Rate:** `1 ETH` to `92 AVT`

## To Contribute

Simply send your ETH directly to the contract. The contract's automatic fallback function will calculate your AVT purchase and transfer it to your address. This means **you should not participate from an exchange!** You will need to transfer it to an independent Ethereum account that _you control_, so that you can transfer your AVT when you receive it.
