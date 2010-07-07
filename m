From: "Soeren D. Schulze" <soeren.d.schulze@gmx.de>
Subject: Re: Still unhappy with removal of DXS controls
Date: Wed, 07 Jul 2010 17:30:21 +0200
Message-ID: <4C349D8D.20707@gmx.de>
References: <4C3234C1.2060901@gmx.de>
	<4C330752.3090201@ladisch.de>	<4C33956B.1060600@gmx.de>
	<4C347A9B.608@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 58A472450C
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Jul 2010 17:30:28 +0200 (CEST)
In-Reply-To: <4C347A9B.608@ladisch.de>
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
List-Id: alsa-devel@alsa-project.org

On 07.07.2010 15:01, Clemens Ladisch wrote:
> Soeren D. Schulze wrote:
>> Is there a chance to get this upstream?
> =

> Yes; would you be OK with this tag?
>   Tested-by: Soeren D. Schulze <soeren.d.schulze@gmx.de>

Yes; I didn't test it that extensively, but it seems to fix the problem.

BTW, the value 24 is still too high if several streams are played at the
same time.


S=F6ren
