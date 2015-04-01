From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 4/4] ASoC: mark of_device_id and device
 data as constant
Date: Wed, 1 Apr 2015 11:12:30 +0200
Message-ID: <20150401091230.GT17728@pengutronix.de>
References: <1427813339-23817-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1427813339-23817-5-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B29AB2605E8
 for <alsa-devel@alsa-project.org>; Wed,  1 Apr 2015 11:12:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1427813339-23817-5-git-send-email-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, Fabian Frederick <fabf@skynet.be>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 31, 2015 at 04:48:59PM +0200, Uwe Kleine-K=F6nig wrote:
> A driver's of_device_id and device data should and can be const.
> =

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
This patch is obsoleted by my patch sent with Message-Id:
20150331183509.GN17728@pengutronix.de [1].

Best regards
Uwe

[1] http://mid.gmane.org/20150331183509.GN17728@pengutronix.de
-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
