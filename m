From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: add DAI platform ssi driver for
 MXC
Date: Tue, 4 Aug 2009 21:17:11 +0100
Message-ID: <20090804201711.GG4342@sirena.org.uk>
References: <eedb5540908040817tc85e5e3j172fb18bcd8e6da0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A51524422
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 22:17:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <eedb5540908040817tc85e5e3j172fb18bcd8e6da0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 04, 2009 at 05:17:58PM +0200, javier Martin wrote:
> This adds support for DAI platform for the SSI present in MXC platforms.
> 
> It currently does not support i.MX3, the only thing necessary to do
> this is to export DMA data for i.MX3 interface which I haven't done
> because I don't have a i.MX3 based board available.

This patch appears to have been mangled by line wrapping - could you
please resend with that fixed or as an attachment?
