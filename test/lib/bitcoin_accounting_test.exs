defmodule BitcoinAccountingTest do
  use ExUnit.Case, async: true
  import Mox

  setup :verify_on_exit!

  describe "get_book_entries/1" do
    test "returns book entries" do
      stub(ElectrumClientMock, :get_address_history, fn
        "12CL4K2eVqj7hQTix7dM7CVHCkpP17Pry3" ->
          [
            %{
              height: 282_306,
              txid: "1b3aa619f7fee859eb78ead57fefb8f0ca0eba050f7a3cec072b5bdab1ebe910"
            }
          ]

        _ ->
          []
      end)

      expect(ElectrumClientMock, :get_transaction, 2, fn
        "1b3aa619f7fee859eb78ead57fefb8f0ca0eba050f7a3cec072b5bdab1ebe910" ->
          sample_tx()

        "94f5a2eb5231daee59fa154c80dddac0e7b1503b001e50980e7daa1a3abc84f6" ->
          input_tx()
      end)

      entries =
        BitcoinAccounting.get_book_entries(
          "xpub661MyMwAqRbcFtXgS5sYJABqqG9YLmC4Q1Rdap9gSE8NqtwybGhePY2gZ29ESFjqJoCu1Rupje8YtGqsefD265TMg7usUDFdp6W1EGMcet8"
        )

      assert %{
               change: [
                 %{address: "1NwEtFZ6Td7cpKaJtYoeryS6avP2TUkSMh", history: []},
                 %{address: "18FcseQ86zCaXzLbgDsH86292xb2EuKtFW", history: []},
                 %{address: "1NZ97rKhSPy6NLud5Dp89E4yH5a2fUGeyC", history: []},
                 %{address: "1GtD6J3DK1SrZu7bqMt1VKGNjhFap7t5Ku", history: []},
                 %{address: "1NitxAxJLdYgJTL5YwKd3N6pD2LPcE8wSY", history: []},
                 %{address: "1LWYcEi1bUMfiCoXJwTXF4q8iRGnqhb8jr", history: []},
                 %{address: "1CEiPmWCaeBboowrPbzBGQtv7SGHGXWbPR", history: []},
                 %{address: "1EtKXtGgnM9oEJThrNDFLjJQpk1fktgjNc", history: []},
                 %{address: "15HkjCP4PwkJqjQ9GVyngEFrEgujan93qz", history: []},
                 %{address: "1eWNxfQVi6wRti9qqsDPQ9pqZqebpXxwF", history: []},
                 %{address: "19r9h32Lr2stSynHkk3yrqZ4VvdnERMxJZ", history: []},
                 %{address: "1NsqgAXszYxNyARKm4E5wEUBjapnMZhaq7", history: []},
                 %{address: "13rZTrjvfsGvZV1EoJ5PLVShLG2r9gEHkm", history: []},
                 %{address: "14vQDPotrcT4cJ4uyXaj9ZtrKREV1MupqU", history: []},
                 %{address: "1HzBqvxEw2rVVw4vGgi8MGtwCZVDjDh642", history: []},
                 %{address: "15cqFniQx2ojWWi2GTKKGUAi6ShsLKXKV3", history: []},
                 %{address: "1EHjziiCcK796GneHXyMH51KTQ6UegzSBo", history: []},
                 %{address: "1JNVQsSHZjAqXDqgFDZEqL5fCxSk8m5cHE", history: []},
                 %{address: "19S2QYjvU6AUpkizuRSpnJi2EK2e6hhGnX", history: []},
                 %{address: "1M3eTqjXY4gKDJT8D63b7abTGeZjiYVHGZ", history: []}
               ],
               receive: [
                 %{
                   address: "12CL4K2eVqj7hQTix7dM7CVHCkpP17Pry3",
                   history: [
                     %{
                       confirmations: 480_868,
                       credits: [12822],
                       debits: [],
                       time: ~U[2014-01-24 23:23:12Z],
                       txid: "1b3aa619f7fee859eb78ead57fefb8f0ca0eba050f7a3cec072b5bdab1ebe910"
                     }
                   ]
                 },
                 %{address: "13Q3u97PKtyERBpXg31MLoJbQsECgJiMMw", history: []},
                 %{address: "1J4LVanjHMu3JkXbVrahNuQCTGCRRgfWWx", history: []},
                 %{address: "1EBPs7ApVkRNy9Y8Z8xLAueeH4wuD1Aixb", history: []},
                 %{address: "1H2RCEj5KFAxY4TvibjKivf8sPipZA62CF", history: []},
                 %{address: "1K6rDJZ54hn4XouChMSp1zcZN5vniP2fzw", history: []},
                 %{address: "1MGxajmnvNKW84o72fRynwzrDXj7htJYBo", history: []},
                 %{address: "1H4STVrrTCPR6qiL7qFUXq97CBr3DHPwxD", history: []},
                 %{address: "1JLhjtQ9E5GyT9HARXc3xFxD9pYvgLzVU2", history: []},
                 %{address: "15MbJzwHGPq5ETKLBp3yPHoxQ5GUB9avyS", history: []},
                 %{address: "17fz4VHcFtJxS4GNoM2AkY76ZXkPUXUKXy", history: []},
                 %{address: "1KgnZTQTagyR7j6quqFnQAecUooPoTZx9K", history: []},
                 %{address: "17PmXRcXGxBXWWhqJeB94cfwbPmy1x9fN", history: []},
                 %{address: "1JgcEGhuFg4Aofmd6HbhCvxBXTPnSY6tXw", history: []},
                 %{address: "1G93sV7huAgSBfzzxi5eTeyq2VXL2MogBS", history: []},
                 %{address: "1LHcicpV6MZQDzZFE2ufDgDcAKUS9RGZSM", history: []},
                 %{address: "1PxLR3iTrEVDCjXGaRnf9bGb9FLMMmWH71", history: []},
                 %{address: "13iVwijHjo59m6HEYzDGM9U7U6pkVwPo83", history: []},
                 %{address: "1PDDAS6aCukFMnveYPDX1EbdxU5syfpEhk", history: []},
                 %{address: "1Db133X5JXnw5fcadHLC84RYRZw8RYrVc3", history: []},
                 %{address: "15gFhS5AXYfWe8BuorRFT3tqmfgxiJJs1T", history: []},
                 %{address: "1FDbCxVK5B3PwpLSQMhHyEJkWUVQXmLsPf", history: []},
                 %{address: "16nWB7Si2hTUtqi71dXtFBreScGWfhyNnm", history: []},
                 %{address: "1Fd8CW7KVjuL3U28WKCVf7AJyrrczg5tdB", history: []},
                 %{address: "1JEYhhAGC2JkLJhdnC1tWk2CtH64sX2Ur8", history: []},
                 %{address: "1Fi9enFgWBaj1rbBeMo687DQqhkfeP6PuE", history: []},
                 %{address: "1LuXPj5WCbABndfc8VHUubVVrn5vrBLtGd", history: []},
                 %{address: "1NJPWgsZSEHSasG1Jt4VakkTznW1GggDM5", history: []},
                 %{address: "1BD2HuuXMYfL3FUfXTgvjPqMxKxTk4uLW4", history: []},
                 %{address: "1L4TJAcK4HB4bLsXyLUMPavzvTnG5mAwEY", history: []},
                 %{address: "1Ephi3U2fvxnxz9CrdLeoZ22LKQqLdN2NV", history: []},
                 %{address: "17HCQvdgQ5MVq5m8KrgqRjUQ1YJjvTVwx2", history: []},
                 %{address: "17W3eLwcRMCafga9a4aLQu13YoCK6jp9bY", history: []},
                 %{address: "18D5AtedNHs9maLibmAmGdBq1W57fsHdFL", history: []},
                 %{address: "1GXdxseg7vgPJFgysp4Jg9P2TkfwSXJ5cm", history: []},
                 %{address: "1DhujbhjZXkF6cHr46Ae6i8XYpURxAFzy", history: []},
                 %{address: "1EYsTLN1stGsh8yKh6k7cceBcfaDtHiJp4", history: []},
                 %{address: "1LkHs8tDbyKmed9eST9GGbMZGeBvzGMzGy", history: []},
                 %{address: "1Nsdbvu3m6Q1n54tZEsZ8zqmN697UKJW6j", history: []},
                 %{address: "1P2dvQmvEdJwk7DZ1kKs9RUzCFTxynZZ3n", history: []}
               ]
             } == entries
    end
  end

  describe "get_address_history/1" do
    test "returns address history" do
      stub(ElectrumClientMock, :get_address_history, fn
        "12CL4K2eVqj7hQTix7dM7CVHCkpP17Pry3" ->
          [
            %{
              height: 282_306,
              txid: "1b3aa619f7fee859eb78ead57fefb8f0ca0eba050f7a3cec072b5bdab1ebe910"
            }
          ]

        _ ->
          []
      end)

      stub(ElectrumClientMock, :get_transaction, fn
        "1b3aa619f7fee859eb78ead57fefb8f0ca0eba050f7a3cec072b5bdab1ebe910" ->
          sample_tx()

        "94f5a2eb5231daee59fa154c80dddac0e7b1503b001e50980e7daa1a3abc84f6" ->
          input_tx()
      end)

      assert [
               %{
                 confirmations: 480_868,
                 credits: [12822],
                 debits: [],
                 time: ~U[2014-01-24 23:23:12Z],
                 txid: "1b3aa619f7fee859eb78ead57fefb8f0ca0eba050f7a3cec072b5bdab1ebe910"
               }
             ] == BitcoinAccounting.get_address_history("12CL4K2eVqj7hQTix7dM7CVHCkpP17Pry3")
    end
  end

  def sample_tx() do
    %{
      block_hash: nil,
      confirmations: 480_868,
      time: ~U[2014-01-24 23:23:12Z],
      transaction: %BitcoinLib.Transaction{
        version: 1,
        id: "1b3aa619f7fee859eb78ead57fefb8f0ca0eba050f7a3cec072b5bdab1ebe910",
        inputs: [
          %BitcoinLib.Transaction.Input{
            txid: "94f5a2eb5231daee59fa154c80dddac0e7b1503b001e50980e7daa1a3abc84f6",
            vout: 1,
            script_sig: [
              %BitcoinLib.Script.Opcodes.Data{
                value:
                  <<0x3045022100C59FF70AE0DA87757FC7C86F5D06EF1BC70FFEF4FBFBB68BA77415D991E3190202207ED140AC74EAB080559C83AFDCF5002F5A6DA30C99A71BC6F23494EC8AC2D1FC01::576>>
              },
              %BitcoinLib.Script.Opcodes.Data{
                value: <<0x02B9B25999478BA88B66B171052D2604024C7748CBFEED54C057332C70FB422D8C::264>>
              }
            ],
            sequence: 4_294_967_295
          }
        ],
        outputs: [
          %BitcoinLib.Transaction.Output{
            value: 12822,
            script_pub_key: [
              %BitcoinLib.Script.Opcodes.Stack.Dup{},
              %BitcoinLib.Script.Opcodes.Crypto.Hash160{},
              %BitcoinLib.Script.Opcodes.Data{value: <<0x0D1C9C02A7BE9BA8B8842804FEB961481CE6561B::160>>},
              %BitcoinLib.Script.Opcodes.BitwiseLogic.EqualVerify{},
              %BitcoinLib.Script.Opcodes.Crypto.CheckSig{
                script: <<0x76A9140D1C9C02A7BE9BA8B8842804FEB961481CE6561B88AC::200>>
              }
            ]
          },
          %BitcoinLib.Transaction.Output{
            value: 8_636_178,
            script_pub_key: [
              %BitcoinLib.Script.Opcodes.Stack.Dup{},
              %BitcoinLib.Script.Opcodes.Crypto.Hash160{},
              %BitcoinLib.Script.Opcodes.Data{value: <<0xF5D5B21CE11D8D79F08046E07D42F3376C10F8A2::160>>},
              %BitcoinLib.Script.Opcodes.BitwiseLogic.EqualVerify{},
              %BitcoinLib.Script.Opcodes.Crypto.CheckSig{
                script: <<0x76A914F5D5B21CE11D8D79F08046E07D42F3376C10F8A288AC::200>>
              }
            ]
          }
        ],
        locktime: 0,
        segwit?: false,
        witness: []
      },
      vsize: 226
    }
  end

  defp input_tx() do
    %{
      block_hash: nil,
      confirmations: 481_079,
      time: ~U[2014-01-23 19:57:07Z],
      transaction: %BitcoinLib.Transaction{
        version: 1,
        id: "94f5a2eb5231daee59fa154c80dddac0e7b1503b001e50980e7daa1a3abc84f6",
        inputs: [
          %BitcoinLib.Transaction.Input{
            txid: "c5e14acb9bf916113ad48e6d5e7cbdadc8806d63c25f57ec342bfa57da7c5796",
            vout: 1,
            script_sig: [
              %BitcoinLib.Script.Opcodes.Data{
                value:
                  <<0x3046022100B889F84219806CDB20560706BB856171E3F96C7118C4841D7998DA3A6EB5E354022100DB8D31A8904C4276418667884D1B32C162DFE6915DF8E46B9CB615612D51574501::584>>
              },
              %BitcoinLib.Script.Opcodes.Data{
                value: <<0x02B9B25999478BA88B66B171052D2604024C7748CBFEED54C057332C70FB422D8C::264>>
              }
            ],
            sequence: 4_294_967_295
          }
        ],
        outputs: [
          %BitcoinLib.Transaction.Output{
            value: 10000,
            script_pub_key: [
              %BitcoinLib.Script.Opcodes.Stack.Dup{},
              %BitcoinLib.Script.Opcodes.Crypto.Hash160{},
              %BitcoinLib.Script.Opcodes.Data{value: <<0x224E6429EAB15626BF446E4D1630B85475A54677::160>>},
              %BitcoinLib.Script.Opcodes.BitwiseLogic.EqualVerify{},
              %BitcoinLib.Script.Opcodes.Crypto.CheckSig{
                script: <<0x76A914224E6429EAB15626BF446E4D1630B85475A5467788AC::200>>
              }
            ]
          },
          %BitcoinLib.Transaction.Output{
            value: 8_659_000,
            script_pub_key: [
              %BitcoinLib.Script.Opcodes.Stack.Dup{},
              %BitcoinLib.Script.Opcodes.Crypto.Hash160{},
              %BitcoinLib.Script.Opcodes.Data{value: <<0xF5D5B21CE11D8D79F08046E07D42F3376C10F8A2::160>>},
              %BitcoinLib.Script.Opcodes.BitwiseLogic.EqualVerify{},
              %BitcoinLib.Script.Opcodes.Crypto.CheckSig{
                script: <<0x76A914F5D5B21CE11D8D79F08046E07D42F3376C10F8A288AC::200>>
              }
            ]
          }
        ],
        locktime: 0,
        segwit?: false,
        witness: []
      },
      vsize: 227
    }
  end
end
