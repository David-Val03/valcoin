import { FC } from "react";
import NavBar from "../components/shared/Navbar";

const HomeView: FC = () => {
  return (
    <div className="min-h-screen bg-gray-900 text-white relative overflow-hidden font-orbitron">
      {/* Starry Background */}
      <div className="absolute inset-0 bg-gradient-to-b from-gray-900 via-purple-900 to-gray-900">
        <div
          className="absolute inset-0"
          style={{
            backgroundImage: `radial-gradient(2px 2px at 20px 30px, #eee, transparent),
                           radial-gradient(2px 2px at 40px 70px, rgba(255,255,255,0.8), transparent),
                           radial-gradient(1px 1px at 90px 40px, #fff, transparent),
                           radial-gradient(1px 1px at 130px 80px, rgba(255,255,255,0.6), transparent),
                           radial-gradient(2px 2px at 160px 30px, #ddd, transparent)`,
            backgroundRepeat: "repeat",
            backgroundSize: "200px 100px",
          }}
        />
      </div>
      
      {/* NavBar */}
      <div className="relative z-20">
        <NavBar />
      </div>

      <div className="relative z-10 container mx-auto px-4 py-8">
        {/* Hero Section */}
        <section className="text-center py-20">
          <h1 className="text-6xl font-bold mb-4 bg-gradient-to-r from-purple-400 to-pink-400 bg-clip-text text-transparent">
            VALCOIN
          </h1>
          <p className="text-xl mb-8 text-gray-300">
            🚀 The Memecoin That's Out of This World! 🌌
          </p>
          <div className="flex justify-center gap-4">
            <button className="bg-purple-600 hover:bg-purple-700 px-8 py-3 rounded-full font-semibold transition-colors">
              Buy VALCOIN
            </button>
            <button className="border border-purple-400 hover:bg-purple-400 hover:text-gray-900 px-8 py-3 rounded-full font-semibold transition-colors">
              View Chart
            </button>
          </div>
        </section>

        {/* Contract Address */}
        <section className="bg-gray-800/50 backdrop-blur-sm rounded-lg p-6 mb-12">
          <h2 className="text-2xl font-bold mb-4 text-center">
            Contract Address
          </h2>
          <div className="bg-gray-900 p-4 rounded-lg text-center">
            <code className="text-purple-400 text-sm break-all">
              0x1234567890abcdef1234567890abcdef12345678
            </code>
            <button className="ml-4 bg-purple-600 hover:bg-purple-700 px-4 py-2 rounded text-sm transition-colors">
              Copy
            </button>
          </div>
        </section>

        {/* Tokenomics */}
        <section className="mb-12">
          <h2 className="text-3xl font-bold text-center mb-8">Tokenomics</h2>
          <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
            <div className="bg-gray-800/50 backdrop-blur-sm p-6 rounded-lg text-center">
              <h3 className="text-xl font-semibold mb-2 text-purple-400">
                Total Supply
              </h3>
              <p className="text-2xl font-bold">1,000,000,000</p>
            </div>
            <div className="bg-gray-800/50 backdrop-blur-sm p-6 rounded-lg text-center">
              <h3 className="text-xl font-semibold mb-2 text-purple-400">
                Liquidity Pool
              </h3>
              <p className="text-2xl font-bold">80%</p>
            </div>
            <div className="bg-gray-800/50 backdrop-blur-sm p-6 rounded-lg text-center">
              <h3 className="text-xl font-semibold mb-2 text-purple-400">
                Marketing
              </h3>
              <p className="text-2xl font-bold">15%</p>
            </div>
            <div className="bg-gray-800/50 backdrop-blur-sm p-6 rounded-lg text-center">
              <h3 className="text-xl font-semibold mb-2 text-purple-400">
                Team
              </h3>
              <p className="text-2xl font-bold">5%</p>
            </div>
          </div>
        </section>

        {/* Roadmap */}
        <section className="mb-12">
          <h2 className="text-3xl font-bold text-center mb-8">Roadmap</h2>
          <div className="space-y-6">
            <div className="flex items-center gap-4">
              <div className="w-4 h-4 bg-green-500 rounded-full flex-shrink-0"></div>
              <div className="bg-gray-800/50 backdrop-blur-sm p-4 rounded-lg flex-1">
                <h3 className="font-semibold text-green-400">
                  Phase 1: Launch ✅
                </h3>
                <p className="text-gray-300">
                  Token creation, website launch, initial marketing
                </p>
              </div>
            </div>
            <div className="flex items-center gap-4">
              <div className="w-4 h-4 bg-yellow-500 rounded-full flex-shrink-0"></div>
              <div className="bg-gray-800/50 backdrop-blur-sm p-4 rounded-lg flex-1">
                <h3 className="font-semibold text-yellow-400">
                  Phase 2: Community Building 🚧
                </h3>
                <p className="text-gray-300">
                  Social media growth, partnerships, exchange listings
                </p>
              </div>
            </div>
            <div className="flex items-center gap-4">
              <div className="w-4 h-4 bg-gray-500 rounded-full flex-shrink-0"></div>
              <div className="bg-gray-800/50 backdrop-blur-sm p-4 rounded-lg flex-1">
                <h3 className="font-semibold text-gray-400">
                  Phase 3: Expansion 🔮
                </h3>
                <p className="text-gray-300">
                  NFT collection, staking rewards, major exchange listings
                </p>
              </div>
            </div>
            <div className="flex items-center gap-4">
              <div className="w-4 h-4 bg-gray-500 rounded-full flex-shrink-0"></div>
              <div className="bg-gray-800/50 backdrop-blur-sm p-4 rounded-lg flex-1">
                <h3 className="font-semibold text-gray-400">
                  Phase 4: To the Moon 🌙
                </h3>
                <p className="text-gray-300">
                  Global adoption, space mission sponsorship, metaverse
                  integration
                </p>
              </div>
            </div>
          </div>
        </section>

        {/* Social Links */}
        <section className="text-center">
          <h2 className="text-2xl font-bold mb-6">
            Join the ValCoin Community
          </h2>
          <div className="flex justify-center gap-6">
            <a
              href="#"
              className="bg-blue-600 hover:bg-blue-700 p-3 rounded-full transition-colors"
            >
              Twitter
            </a>
            <a
              href="#"
              className="bg-purple-600 hover:bg-purple-700 p-3 rounded-full transition-colors"
            >
              Discord
            </a>
            <a
              href="#"
              className="bg-orange-600 hover:bg-orange-700 p-3 rounded-full transition-colors"
            >
              Telegram
            </a>
          </div>
        </section>
      </div>
    </div>
  );
};

export default HomeView;
