From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TPA6130A2: Make tpa6130a2_power as
	static
Date: Mon, 12 Oct 2009 11:42:13 +0300
Message-ID: <200910121142.13313.peter.ujfalusi@nokia.com>
References: <1255333290-24291-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 4EA4724599
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Oct 2009 10:42:24 +0200 (CEST)
In-Reply-To: <1255333290-24291-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Monday 12 October 2009 10:41:30 Ujfalusi Peter (Nokia-D/Tampere) wrote:
> The power for the amplifier should be handled internally
> by the tpa6130a2 driver.

Please ignore this patch, I'll resend and remove the tpa6130a2_power from t=
he =

header as well.

-- =

P=E9ter
