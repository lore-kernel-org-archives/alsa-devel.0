From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ASoC: OMAP/TI upstream route
Date: Tue, 27 Apr 2010 08:31:05 +0100
Message-ID: <1272353465.3204.19.camel@odin>
References: <1272293803.3208.85.camel@odin>
	<20100426192228.228489c7.jhnikula@gmail.com>
	<1272302027.3208.209.camel@odin>
	<201004270926.34345.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E8012482F
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Apr 2010 09:31:12 +0200 (CEST)
Received: by wwg30 with SMTP id 30so344948wwg.38
	for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2010 00:31:09 -0700 (PDT)
In-Reply-To: <201004270926.34345.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "Olaya, Margarita" <magi.olaya@ti.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-04-27 at 09:26 +0300, Peter Ujfalusi wrote:
> Hi,
> 
> On Monday 26 April 2010 20:13:47 ext Liam Girdwood wrote:
> > 
> > Everything is just carrying on as before except the upstream management
> > effort is being divided between Mark and I. i.e. I'll manage the TI/OMAP
> > based patches, Mark will manage the rest.
> 
> I see, it make sense.
> Are we continuing the practice that in case of OMAP (McBSP) patches Jarkko 
> or/and I have to ack it in order to be accepted?
> I'm also the maintainer for the twl4030 ASoC codec driver (see MAINTAINERS 
> file)...


Yes, nothing has changed here. :)

> > Patch submitters should not notice any difference as both trees are
> > based on Takashi's ASoC branch and are regularly kept up to date.
> 
> Just to clarify it: You and Mark will send pull request to Takashi, 

yes

> or is it 
> going to be You -> Mark -> Takashi route?

and yes. Depending on workload, any merge issues, cross tree patches
etc.

Liam 

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
