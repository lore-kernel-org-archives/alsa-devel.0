From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 0/4] ASoC: omap-mcpdm/twl6040: Offset
	cancellation
Date: Mon, 26 Sep 2011 13:39:02 +0300
Message-ID: <1587744.O8e9UvE8k4@barack>
References: <1316090718-30822-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
	[74.125.149.149])
	by alsa0.perex.cz (Postfix) with ESMTP id DCB992457A
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 12:38:55 +0200 (CEST)
Received: by mail-bw0-f48.google.com with SMTP id zu5so5393351bkb.7
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 03:38:54 -0700 (PDT)
In-Reply-To: <1316090718-30822-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Liam,

On Thursday 15 September 2011 15:45:14 Peter Ujfalusi wrote:
> Hello,
> =

> The following series adds support for the McPDM offset cancellation featu=
re.
> It provides the needed functionality to:
> - read the HSTRIM values from the twl6040 codec
> - configure the offset cancellation registers in OMAP-McPDM

can you take a look at this series?
Mark already acked it, but I think your ack is needed so Mark can apply the=
se =

for 3.2.

Thanks,
P=E9ter
