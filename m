From: Graeme Gregory <gg@opensource.wolfsonmicro.com>
Subject: Re: [ASoC]one Small Suggestion
Date: Fri, 08 Jun 2007 08:56:27 +0100
Message-ID: <1181289387.9717.3.camel@gg-desktop.wolfsonmicro.main>
References: <8d6898730706070558r6c5c08aft8e00563b7a8ba607@mail.gmail.com>
	<8d6898730706080047x37a2ddb4m9766246017e43029@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 151C92467A
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2007 10:00:08 +0200 (CEST)
In-Reply-To: <8d6898730706080047x37a2ddb4m9766246017e43029@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nobin Mathew <nobin.mathew@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2007-06-08 at 13:17 +0530, Nobin Mathew wrote:
> Adding a nice proc interface to read codec registers will be a nice
> feature have, like we have in generic ac97 registers, i added that
> that in wm9713.c by using ac97_proc.c
> 
You mean like /sys/devices/platform/soc-audio/codec_reg :-)

Liam is working currently on the private data issue in his new edition
of ASoC coming soon.

Graeme (sitting 4 feet to left of Liam).
