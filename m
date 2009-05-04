From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 2/2] ASoC: TWL4030: Add voice digital
	loopback: sidetone
Date: Mon, 4 May 2009 08:29:44 +0300
Message-ID: <200905040829.44996.peter.ujfalusi@nokia.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F63E0BA8@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 33BE01037F7
	for <alsa-devel@alsa-project.org>;
	Mon,  4 May 2009 07:29:51 +0200 (CEST)
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705F63E0BA8@dlee07.ent.ti.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Friday 01 May 2009 05:48:08 ext Lopez Cruz, Misael wrote:
> This patch add voice digital loopback (sidetone) to the twl4030
> driver. It mixes voice uplink attenuated (by sidetone gain) with
> voice downlink when the codec is working in option2 (voice/audio
> mode).
>
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
