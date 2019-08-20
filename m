From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] ASoC: uniphier: Fix double reset assersion when
 transitioning to suspend state
Date: Tue, 20 Aug 2019 08:34:31 +0200
Message-ID: <20190820063431.bveflsr6xtu7637h@pengutronix.de>
References: <1566281764-14059-1-git-send-email-hayashi.kunihiko@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1566281764-14059-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-arm-kernel@lists.infradead.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hello,

just noticed while reading through my linux-arm-kernel folder:

$Subject ~= s/assersion/assertion/

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
