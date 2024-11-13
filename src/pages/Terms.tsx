import React from 'react';

const Terms = () => {
  return (
    <div className="max-w-4xl mx-auto px-4 py-12">
      <h1 className="text-3xl font-bold text-gray-900 mb-8">Terms and Conditions</h1>
      
      <div className="prose prose-blue max-w-none">
        <section className="mb-8">
          <h2 className="text-2xl font-semibold text-gray-900 mb-4">1. Acceptance of Terms</h2>
          <p className="text-gray-600 mb-4">
            By downloading, installing, or using CGPAViz, you agree to be bound by these terms and conditions.
            If you disagree with any part of these terms, you may not use our services.
          </p>
        </section>

        <section className="mb-8">
          <h2 className="text-2xl font-semibold text-gray-900 mb-4">2. Use License</h2>
          <p className="text-gray-600 mb-4">
            Permission is granted to temporarily download one copy of CGPAViz for personal,
            non-commercial transitory viewing only.
          </p>
          <p className="text-gray-600 mb-4">
            This is the grant of a license, not a transfer of title, and under this license you may not:
          </p>
          <ul className="list-disc pl-6 text-gray-600 mb-4">
            <li>Modify or copy the materials</li>
            <li>Use the materials for any commercial purpose</li>
            <li>Attempt to decompile or reverse engineer any software contained in CGPAViz</li>
            <li>Remove any copyright or other proprietary notations from the materials</li>
            <li>Transfer the materials to another person or "mirror" the materials on any other server</li>
          </ul>
        </section>

        <section className="mb-8">
          <h2 className="text-2xl font-semibold text-gray-900 mb-4">3. Disclaimer</h2>
          <p className="text-gray-600 mb-4">
            The materials within CGPAViz are provided on an 'as is' basis. CGPAViz makes no warranties,
            expressed or implied, and hereby disclaims and negates all other warranties including,
            without limitation, implied warranties or conditions of merchantability, fitness for a
            particular purpose, or non-infringement of intellectual property or other violation of rights.
          </p>
        </section>

        <section className="mb-8">
          <h2 className="text-2xl font-semibold text-gray-900 mb-4">4. Limitations</h2>
          <p className="text-gray-600 mb-4">
            In no event shall CGPAViz or its suppliers be liable for any damages (including, without
            limitation, damages for loss of data or profit, or due to business interruption) arising
            out of the use or inability to use CGPAViz.
          </p>
        </section>

        <section className="mb-8">
          <h2 className="text-2xl font-semibold text-gray-900 mb-4">5. Revisions and Errata</h2>
          <p className="text-gray-600 mb-4">
            The materials appearing in CGPAViz could include technical, typographical, or photographic
            errors. CGPAViz does not warrant that any of the materials on its software are accurate,
            complete or current.
          </p>
        </section>

        <section>
          <h2 className="text-2xl font-semibold text-gray-900 mb-4">6. Contact Information</h2>
          <p className="text-gray-600">
            If you have any questions about these Terms and Conditions, please contact us through
            our contact page.
          </p>
        </section>
      </div>
    </div>
  );
};

export default Terms;