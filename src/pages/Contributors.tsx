import React from 'react';
import { Github, Linkedin, Globe } from 'lucide-react';

const Contributors = () => {
  const contributors = [
    {
      name: "Sarah Chen",
      role: "Lead Developer",
      image: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&h=200&q=80",
      bio: "Full-stack developer with expertise in data visualization and React. Created the core architecture of CGPAViz.",
      github: "https://github.com",
      linkedin: "https://linkedin.com",
      website: "https://example.com"
    },
    {
      name: "Michael Rodriguez",
      role: "UI/UX Designer",
      image: "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=200&h=200&q=80",
      bio: "Designer passionate about creating intuitive user experiences. Responsible for CGPAViz's beautiful interface.",
      github: "https://github.com",
      linkedin: "https://linkedin.com",
      website: "https://example.com"
    },
    {
      name: "David Kim",
      role: "Backend Developer",
      image: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=200&h=200&q=80",
      bio: "Specialized in data processing and optimization. Implemented the core calculation engine.",
      github: "https://github.com",
      linkedin: "https://linkedin.com",
      website: "https://example.com"
    },
    {
      name: "Emily Watson",
      role: "Data Scientist",
      image: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=200&h=200&q=80",
      bio: "Expert in statistical analysis and data modeling. Developed the grade prediction algorithms.",
      github: "https://github.com",
      linkedin: "https://linkedin.com",
      website: "https://example.com"
    }
  ];

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Hero Section */}
      <section className="bg-gradient-to-r from-blue-600 to-green-500 text-white py-16">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h1 className="text-4xl font-bold mb-4">Meet Our Team</h1>
          <p className="text-xl text-blue-100 max-w-2xl mx-auto">
            The talented individuals behind CGPAViz who make academic visualization simple and beautiful
          </p>
        </div>
      </section>

      {/* Contributors Grid */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
          {contributors.map((contributor, index) => (
            <div
              key={index}
              className="bg-white rounded-lg shadow-md overflow-hidden transition-transform duration-300 hover:-translate-y-1"
            >
              <div className="p-6">
                <img
                  src={contributor.image}
                  alt={contributor.name}
                  className="w-32 h-32 rounded-full mx-auto mb-4 object-cover"
                />
                <h3 className="text-xl font-semibold text-gray-900 text-center mb-1">
                  {contributor.name}
                </h3>
                <p className="text-blue-600 text-center mb-4">
                  {contributor.role}
                </p>
                <p className="text-gray-600 text-sm mb-4">
                  {contributor.bio}
                </p>
                <div className="flex justify-center space-x-4">
                  <a
                    href={contributor.github}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-gray-600 hover:text-blue-600 transition-colors"
                  >
                    <Github className="h-5 w-5" />
                  </a>
                  <a
                    href={contributor.linkedin}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-gray-600 hover:text-blue-600 transition-colors"
                  >
                    <Linkedin className="h-5 w-5" />
                  </a>
                  <a
                    href={contributor.website}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-gray-600 hover:text-blue-600 transition-colors"
                  >
                    <Globe className="h-5 w-5" />
                  </a>
                </div>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* Join Us Section */}
      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16 text-center">
        <h2 className="text-3xl font-bold text-gray-900 mb-4">
          Want to Contribute?
        </h2>
        <p className="text-gray-600 max-w-2xl mx-auto mb-8">
          We're always looking for talented developers, designers, and data scientists to join our team.
          If you're passionate about education and technology, we'd love to hear from you.
        </p>
        <a
          href="https://github.com/cgpaviz"
          target="_blank"
          rel="noopener noreferrer"
          className="inline-flex items-center space-x-2 bg-gradient-to-r from-blue-600 to-green-500 text-white px-6 py-3 rounded-lg hover:opacity-90 transition-opacity"
        >
          <Github className="h-5 w-5" />
          <span>Join us on GitHub</span>
        </a>
      </section>
    </div>
  );
};

export default Contributors;