From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] asoc: davinci: let platform data define
 edma queue numbers
Date: Tue, 20 Jul 2010 09:57:40 +0100
Message-ID: <20100720085739.GI10222@rakim.wolfsonmicro.main>
References: <1279522876-11834-1-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 125B41038D0
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 10:57:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1279522876-11834-1-git-send-email-nsekhar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 19, 2010 at 12:31:16PM +0530, Sekhar Nori wrote:
> Currently the EDMA queue to be used by for servicing ASP through
> internal RAM is fixed to EDMAQ_0 and that to service internal RAM
> from external RAM is fixed to EDMAQ_1.

Applied, thanks.

It's "ASoC", BTW.
