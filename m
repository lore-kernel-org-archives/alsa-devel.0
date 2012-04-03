From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: core: Initialize err for
	snd_soc_put_volsw_sx
Date: Tue, 3 Apr 2012 11:24:09 -0500
Message-ID: <alpine.DEB.2.02.1204031123340.21413@heelrod.ad.cirrus.com>
References: <1333467752-19132-1-git-send-email-brian.austin@cirrus.com>
	<20120403160735.GA1260@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1926690598-1333470249=:21413"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
	(tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 5EA7D103B5F
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Apr 2012 18:25:01 +0200 (CEST)
In-Reply-To: <20120403160735.GA1260@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

--8323329-1926690598-1333470249=:21413
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Apr 2012, Mark Brown wrote:

> On Tue, Apr 03, 2012 at 10:42:32AM -0500, Brian Austin wrote:
>> sound/soc/soc-core.c: In function =E2=80=98snd_soc_put_volsw_sx=E2=80=99=
:
>> sound/soc/soc-core.c:2600: warning: =E2=80=98err=E2=80=99 may be used =
uninitialized in this function
>>
>> Acked-by:Brian Austin <brian.austin@cirrus.com>
>
> This should be Signed-off-by (change looks good).
>
doh!

want me to resend?
--8323329-1926690598-1333470249=:21413
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--8323329-1926690598-1333470249=:21413--
