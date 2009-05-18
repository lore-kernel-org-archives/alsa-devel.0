From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/3] ASoC: TWL4030: Enable/disable voice
	digital filters
Date: Mon, 18 May 2009 11:35:18 +0300
Message-ID: <200905181135.18611.peter.ujfalusi@nokia.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F69E8123@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 78ADC1037FD
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 10:35:24 +0200 (CEST)
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705F69E8123@dlee07.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ext Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Monday 18 May 2009 04:02:31 ext Lopez Cruz, Misael wrote:
> Enable TWL4030 VTXL/VTXR and VRX digital filters for uplink
> and downlink paths, respectively.
>
> This patch also corrects voice 8/16kHz mode selection bit
> (SEL_16K) of CODEC_MODE register.
>
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>

Looks good, thanks.

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

-- =

P=E9ter
