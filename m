From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 13/22] docs: soundwire: locking: fix tags for a
 code-block
Date: Tue, 4 Jun 2019 20:49:16 +0530
Message-ID: <20190604151916.GK15118@vkoul-mobl>
References: <cover.1559656538.git.mchehab+samsung@kernel.org>
 <0ea9c284f8db3867985c410d2764a2b68e5b35c1.1559656538.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0ea9c284f8db3867985c410d2764a2b68e5b35c1.1559656538.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Sanyog Kale <sanyog.r.kale@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04-06-19, 11:17, Mauro Carvalho Chehab wrote:
> There's an ascii artwork at Example 1 whose code-block is not properly
> idented, causing those warnings.
> 
>     Documentation/driver-api/soundwire/locking.rst:50: WARNING: Inconsistent literal block quoting.
>     Documentation/driver-api/soundwire/locking.rst:51: WARNING: Line block ends without a blank line.
>     Documentation/driver-api/soundwire/locking.rst:55: WARNING: Inline substitution_reference start-string without end-string.
>     Documentation/driver-api/soundwire/locking.rst:56: WARNING: Line block ends without a blank line.

Applied, thanks

-- 
~Vinod
