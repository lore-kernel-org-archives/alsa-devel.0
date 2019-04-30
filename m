From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [GIT PULL] soundwire updates for v5.2-rc1
Date: Tue, 30 Apr 2019 14:12:15 +0530
Message-ID: <20190430084203.GR3845@vkoul-mobl.Dlink>
References: <20190429112829.GH3845@vkoul-mobl.Dlink>
 <20190429114337.GA16771@kroah.com>
 <20190429114617.GJ3845@vkoul-mobl.Dlink>
 <24c3eef6-2a91-afbd-04f1-2e9a0db29f1c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A02CF8065C
 for <alsa-devel@alsa-project.org>; Tue, 30 Apr 2019 11:17:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <24c3eef6-2a91-afbd-04f1-2e9a0db29f1c@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 29-04-19, 07:53, Pierre-Louis Bossart wrote:
> On 4/29/19 6:46 AM, Vinod Koul wrote:
> > On 29-04-19, 13:43, Greg KH wrote:
> > > On Mon, Apr 29, 2019 at 04:58:29PM +0530, Vinod Koul wrote:
> > > > Hey Greg,
> > > > 
> > > > Please PULL to receive updates to soundwire subsystem
> > > > 
> > > > The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> > > > 
> > > >    Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> > > > 
> > > > are available in the Git repository at:
> > > > 
> > > >    git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.2-rc1
> > > 
> > > Pulled and pushed out, thanks,
> > 
> > That was fast :)
> 
> Vinod, is there any reason why you didn't take the rest of my clean-up
> patches? The feedback you provided wasn't really relevant (patches do apply
> and alignment is fine) and you didn't reply to my questions. 

Sorry I though base don comments a v2 was coming, I will recheck and see
if there is anything pending from my side. Nevertheless whats gets into
a PULL request is frozen some days back, even if I had applied
afterwards chances are that it wont have gone into this one. But hey
there is always next one...

> That's not 
> 'fast'. If we start having such delays with trivial patches, I can only
> imagine how well this is going to work with the rest of the patches I am
> cooking...

I never claim to be as fast as Greg :) But delays will be there, without
seeing rest of the patches I cant comment. But yes you can make it easy
for people to review which ensures they get done faster

Anyway lets discuss those points in relevant threads.

Thanks
-- 
~Vinod
