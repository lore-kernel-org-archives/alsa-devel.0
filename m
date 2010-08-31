From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Swap bias level enumeration
Date: Tue, 31 Aug 2010 13:06:17 +0100
Message-ID: <20100831120617.GH20849@rakim.wolfsonmicro.main>
References: <1283255555-1547-1-git-send-email-jhnikula@gmail.com>
	<1283256224.3147.43.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A84B41037F3
	for <alsa-devel@alsa-project.org>;
	Tue, 31 Aug 2010 14:06:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1283256224.3147.43.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 31, 2010 at 01:03:44PM +0100, Liam Girdwood wrote:
> On Tue, 2010-08-31 at 14:52 +0300, Jarkko Nikula wrote:

> > Swapping the bias level enumeration is only meant to help debugging. It is
> > easier if number 0 means bias off and bigger number means bigger bias level.

> Good point.

Personally I always display as plain text which is even more legible :)

Applied, thanks.
