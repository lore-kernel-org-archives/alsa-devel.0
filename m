From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Multi-component: Use a more	adequate
	name for the CX20442 codec DAI
Date: Thu, 19 Aug 2010 15:30:19 +0100
Message-ID: <20100819143019.GA29184@sirena.org.uk>
References: <201008191515.51877.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E38D24427
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 16:30:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201008191515.51877.jkrzyszt@tis.icnet.pl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 19, 2010 at 03:15:50PM +0200, Janusz Krzysztofik wrote:
> In the process of unification of codec DAI names while implementing 
> multi-component, the CX20442 codec DAI has been renamed to "cx20442-hifi". 
> This new name seems not adequate for a 8kHz voice codec.

Applied.  Please, do try to remember that you need to CC maintainers
when posting patches.
