From: Ben Dooks <ben-alsa@fluff.org>
Subject: Re: [patch 0/9] S3C24XX/S3C64XX updates
Date: Wed, 11 Mar 2009 10:39:36 +0000
Message-ID: <20090311103936.GA18264@trinity.fluff.org>
References: <20090304004925.530566010@fluff.org.uk>
	<20090304202952.GA10731@sirena.org.uk>
	<s5hvdqofn6a.wl%tiwai@suse.de>
	<20090305103111.GA2416@sirena.org.uk>
	<s5h8wnk45ot.wl%tiwai@suse.de>
	<20090305110259.GC2416@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	by alsa0.perex.cz (Postfix) with ESMTP id 00C39103845
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 11:39:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090305110259.GC2416@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, Ben Dooks <ben-alsa@fluff.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 05, 2009 at 11:03:00AM +0000, Mark Brown wrote:
> On Thu, Mar 05, 2009 at 11:36:34AM +0100, Takashi Iwai wrote:
> > Mark Brown wrote:
> 
> > > I could separate it out and push a separate branch via Russell as well
> > > but that'd make more work for him and he's been having some very bad
> > > network problems in addition to all the stuff he normally has to do so
> > > I'm not sure he'd welcome more work right now.
> 
> > Then it must be OK to keep the changes in our tree.  Though, it'd be
> > nice to have Russell's ack beforehand.
> > Maybe we can separate the header-move patch to another branch so that
> > he can pull it in easily if needed.
> 
> OK, I'll create the separate branch and merge it into the branch I push
> to you - Ben, I guess it'll be best to merge that one into whatever you
> push to Russell?

At the moment this is still in your for-2.6.30 branch, do I need to look
at doing anything about it?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
