From: Vinod <vkoul@kernel.org>
Subject: Re: [ANNOUNCE] 2018 Linux Audio miniconference
Date: Mon, 27 Aug 2018 18:07:03 +0530
Message-ID: <20180827123703.GZ2388@vkoul-mobl>
References: <20180810110656.GE20971@sirena.org.uk>
 <20180816160233.GA5656@sirena.org.uk>
 <ee7acc7f7754dd76b730874bae413a7f3c9804cc.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FACB2676BF
 for <alsa-devel@alsa-project.org>; Mon, 27 Aug 2018 14:37:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ee7acc7f7754dd76b730874bae413a7f3c9804cc.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 23-08-18, 12:18, Liam Girdwood wrote:
> On Thu, 2018-08-16 at 17:02 +0100, Mark Brown wrote:
> > On Fri, Aug 10, 2018 at 12:06:56PM +0100, Mark Brown wrote:
> > 
> > 
> > > As with previous years let's pull together an agenda through a mailing
> > > list discussion - if people could reply to this mail with any topics
> > > they'd like to discuss we can take it from there.  Of course if we can
> > > sort things out more quickly via the mailing list that's even better!
> > 
> > Not much discussion yet - one topic I think there's some useful
> > discussion to be had about is DSPs, we've got the recent Intel work with
> > Sound Open Firmware opening things up there and potentially being able
> > to offload work from the userspace sound servers.
> > 
> 
> I'm also thinking soundwire, AVB (audio over ethernet) and audio virtualisation
> as other topics too.

Yeah I am going to be there and can discuss soundwire :-)
> 
> Fwiw, we should be able to virtualise SOF soon so it would be probably good to
> discuss audio virtualisation in general and the pain points for virtualising
> audio around latency and reducing buffer copies.

I think last meeting folks had discussed about the byte control
interface? Did anyone get around to work on that. I would like to
discuss that again.

-- 
~Vinod
