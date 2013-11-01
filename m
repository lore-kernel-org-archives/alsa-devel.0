From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Subject: [PATCH 0/2] wm8962: Add ALC and EQ coefficients
Date: Fri, 1 Nov 2013 10:00:52 +0000
Message-ID: <20131101100051.GA1901@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Two patches to expose the coefficient blocks for the
ALC and EQ filters.

Richard Fitzgerald (2):
  ASoC: wm8962: Add ALC coefficient support
  ASoC: wm8962: Add EQ coefficient support

 sound/soc/codecs/wm8962.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

-- 
1.7.2.5
