From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: pxa-ssp.c fix clock/frame invert
Date: Wed, 8 Apr 2009 19:13:03 +0100
Message-ID: <20090408181302.GA7549@sirena.org.uk>
References: <1239198684.20192.8.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A75F710380A
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Apr 2009 20:13:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1239198684.20192.8.camel@brutus>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Ribeiro <drwyrm@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, openezx-devel <openezx-devel@lists.openezx.org>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 08, 2009 at 10:51:24AM -0300, Daniel Ribeiro wrote:

> This patch also adds all possible NF/IF, NB/IB combinations to the DSP_A and
> DSP_B modes.

Thanks - it'll be tomorrow or possibly Monday before I get a chance to
test this.
