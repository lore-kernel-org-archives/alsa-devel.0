From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC Peek individual register debugfs
Date: Fri, 22 Jul 2011 10:07:57 +0100
Message-ID: <20110722090757.GG23192@opensource.wolfsonmicro.com>
References: <4E28C543.5090802@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8265C243EB
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jul 2011 11:08:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E28C543.5090802@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Lai <plai@codeaurora.org>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, brubin@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 21, 2011 at 05:33:07PM -0700, Patrick Lai wrote:

> Does latest soc-core.c provide debugfs interface for peeking individual
> register? If not, I plan to add this interface.

codec_reg.  This is the sort of question that can easily be answered by
looking at the code, or a running system.
