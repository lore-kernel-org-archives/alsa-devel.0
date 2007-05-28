From: dustin@seznam.cz
Subject: Re: ICE1724 alsa driver
Date: Mon, 28 May 2007 10:48:18 +0200 (CEST)
Message-ID: <10237.25773-11092-1347170241-1180342098@seznam.cz>
References: <loom.20070523T194915-68@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxh.seznam.cz (mxhn.seznam.cz [212.80.76.26])
	by alsa0.perex.cz (Postfix) with SMTP id 7F994246FE
	for <alsa-devel@alsa-project.org>;
	Mon, 28 May 2007 10:48:22 +0200 (CEST)
In-Reply-To: <loom.20070523T194915-68@post.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rossco <r.maclachlan@strath.ac.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Ross,

I apologize for a delayed  reply. Joint work on adding support to your card=
 sounds certainly interesting to me, it's just the current time pressure an=
d a work on another card I would like to finish first. One or two weeks I h=
ope.

Regards,

Pavel.




>  ------------ P=F9vodn=ED zpr=E1va ------------
>  Od: Rossco <r.maclachlan@strath.ac.uk>
>  P=F8edm=ECt: Re: [alsa-devel] ICE1724 alsa driver
>  Datum: 23.5.2007 19:55:37
>  ----------------------------------------
>   <dustin <at> seznam.cz> writes:
>  =

>  > =

>  > Hello Ross,
>  > =

>  > what kind of SPDIF receiver the HV-7.1CH Hitpoint card uses? =

>  > =

>  > http://www.hitpoint.com.tw/computer/en/product/soundcard/via/hv-71ch.h=
tm
>  > =

>  > I guess it is the chip right next to the two TOSLINK connectors. If it=
 is
>  CS8415 (looks similar), support for
>  > this chip could be taken from aureon.c, or perhaps the whole aureon co=
de
>  would
>  fit this card better than the
>  > amp.c code with Chaintec AV710.
>  > =

>  > Regards,
>  > =

>  =

>  =

>  Hi Pavel,
>  =

>  I replied to you be email, just realised this should probably have been =
through
>  the list. It is a CS8415. I would be grateful if you could advise how I =
might
>  go
>  about trying the aureon.c with the hitpoint (I am new to ALSA and indeed
>  linux).
>  Or is this something that needs further developer attention and informat=
ion
>  about the card (I will provide anything required)?
>  =

>  Regards,
>  =

>  Ross
>  =

>  _______________________________________________
>  Alsa-devel mailing list
>  Alsa-devel@alsa-project.org
>  http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>  =

>  =

>  =
