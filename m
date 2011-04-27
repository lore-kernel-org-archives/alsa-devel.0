From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: Allow platform drivers to have
	no ops structure
Date: Wed, 27 Apr 2011 18:57:20 +0100
Message-ID: <20110427175720.GB21499@opensource.wolfsonmicro.com>
References: <1303925257-26920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4DB85743.1080806@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B9967243B4
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Apr 2011 19:57:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DB85743.1080806@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, patches@opensource.wolfsonmicro.com, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 27, 2011 at 07:49:55PM +0200, Lars-Peter Clausen wrote:

> This hunk looks as if it belongs to a different series. There is currently no
> 'no_cpu' field in the snd_soc_dai_link struct.

Yes, it does.  Please review assuming that's dropped.
