From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: TWL4030: Fix voice interface
 clock masters
Date: Mon, 22 Jun 2009 11:25:07 +0100
Message-ID: <20090622102505.GA4730@sirena.org.uk>
References: <67059DBF19D7214F9C66BB0EA91BA90E3543F31E@dlee04.ent.ti.com>
	<200906220935.27903.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C50824344
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Jun 2009 12:25:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200906220935.27903.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ext Lopez Cruz, Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 22, 2009 at 09:35:27AM +0300, Peter Ujfalusi wrote:
> On Friday 19 June 2009 11:23:42 ext Lopez Cruz, Misael wrote:

> > Voice interface of twl4030 codec supports: CBM_CFM and
> > CBS_CFS. It doesn't support CBS_CFM.

> Acked-By: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Applied, thanks.

Peter, you might want to submit a MAINTAINERS entry for TWL4030 - you're
doing a lot of good review there.
