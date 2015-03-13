From: Antonio Ospite <ao2@ao2.it>
Subject: Re: [PATCH 0/5] Intel SST driver restructure
Date: Fri, 13 Mar 2015 15:32:06 +0100
Message-ID: <20150313153206.4ef29f561736f07c34a5de06@ao2.it>
References: <1426170720-8260-1-git-send-email-yang.jie@intel.com>
 <20150312195420.GB28806@sirena.org.uk>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BD6C63@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp205.alice.it (smtp205.alice.it [82.57.200.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 8874C2651B8
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 15:32:17 +0100 (CET)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A901BD6C63@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "Li, Jocelyn" <jocelyn.li@intel.com>, Mark Brown <broonie@kernel.org>, "Chehab, John" <john.chehab@intel.com>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "Jin, Yao" <yao.jin@intel.com>, "Bossart, Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 13 Mar 2015 01:28:00 +0000
"Jie, Yang" <yang.jie@intel.com> wrote:

[...]
> > On Thu, Mar 12, 2015 at 10:31:55PM +0800, Jie Yang wrote:
> > > In order to prepare for the upstreaming of Skylake drivers and to
> > > allow reuse of code between different Intel audio DSP products, this
> > > patch series restructures the Intel directory as follows:
> > 
> > This is all fine by me - I'd just like to see an ack before we do this from the
> > other Intel people to make sure they're not going to get surprised, and also
> [Keyon] understood. I have sent this series to Intel internal before here, and
> Most Intel Linux Audio driver people should have known about this change.
> Vinod(Atoms & BSW), Jarkko(Baytrail), Mengdong(BSW), Liam(Haswell), 
> could you please help add 'acked-by' if it's OK for you? Thanks.
[...]

Please, insert a blank line between the quote and the reply, it makes
it easier to follow the discussion.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
