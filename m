From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: soc-cache: Use reg_def_copy
 instead of reg_cache_default
Date: Thu, 6 Jan 2011 00:15:17 +0000
Message-ID: <4D250995.4020409@freescale.com>
References: <1291306266-4907-1-git-send-email-dp@opensource.wolfsonmicro.com>
	<1291306266-4907-2-git-send-email-dp@opensource.wolfsonmicro.com>
	<AANLkTi=yFRw-c+LeQGEUkKuAGCV+tkEYEpo=q22F0ZUq@mail.gmail.com>
	<20110105230339.GB5476@opensource.wolfsonmicro.com>
	<4D24F9E4.1080704@freescale.com> <20110105232947.GA8514@sirena.org.uk>
	<20110105235115.GB5714@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from AM1EHSOBE001.bigfish.com (am1ehsobe001.messaging.microsoft.com
	[213.199.154.204])
	by alsa0.perex.cz (Postfix) with ESMTP id EFBE42447C
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 01:15:53 +0100 (CET)
In-Reply-To: <20110105235115.GB5714@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <49323d28-931d-4e1b-bfe0-cc9b4857f93c>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> More generally though what I'm trying to say is more about the approach
> that's being taken here; with things like this it's generally much
> better to at least have a dig into what's not working for you and have
> an idea of what's going on rather than just stopping and asking.  This
> is normally easier all round, either you'll be able to sort stuff out
> yourself or you'll be able to ask a much better question.

Mark, you don't need to explain the philosophy of open source development to me. :-)

I just wanted to get the idea of what you and others intended with the current register cache code, just as a matter of context.  I like to understand these things *before* I start digging around.

-- 
Timur Tabi
Linux kernel developer
