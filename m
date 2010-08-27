From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ARM: S3C64XX: Fix fallthrough bug in i2sv3
 gpio configuration, improve logging
Date: Fri, 27 Aug 2010 11:18:40 +0100
Message-ID: <1282904320.3025.2.camel@odin>
References: <1282835243-20493-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<20100826152140.GB4363@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id DBDC92453D
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Aug 2010 12:18:43 +0200 (CEST)
Received: by wyb32 with SMTP id 32so3216487wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 27 Aug 2010 03:18:43 -0700 (PDT)
In-Reply-To: <20100826152140.GB4363@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-08-26 at 16:21 +0100, Mark Brown wrote:
> On Thu, Aug 26, 2010 at 04:07:23PM +0100, Dimitris Papastamos wrote:
> 
> > This is a fix for a change in ASoC multi-component as well.
> 
> Clarifying from offline discussion: the issue isn't present in mainline,
> it came in with m-c.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
