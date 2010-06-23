From: =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>
Subject: Re: imx-ssi.c &amp; SND_SOC_DAIFMT_I2S
Date: Wed, 23 Jun 2010 12:28:40 +0200
Message-ID: <4C21E1D8.3080608@eukrea.com>
References: <4BFCEB10.6000205@eukrea.com>	<20100527005647.GC22091@sirena.org.uk>	<4BFDC7C7.7000507@eukrea.com>
	<loom.20100623T120433-100@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 27.mail-out.ovh.net (27.mail-out.ovh.net [91.121.30.210])
	by alsa0.perex.cz (Postfix) with SMTP id 890A02441D
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 12:28:43 +0200 (CEST)
In-Reply-To: <loom.20100623T120433-100@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: anilkumar <kollianil2009@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Anil,

Le 23/06/2010 12:15, anilkumar a =E9crit :
> Please send me the configuration [if any changes] from i.mx ssi slave and
> tlv320aic33.
>
I'm using TLV320AI23 and not the 33 so I don't know the necessary =

changes for your codec but this look like you could start from =

eukrea-tlv320.c and update it for tlv320aic33.

Eric
