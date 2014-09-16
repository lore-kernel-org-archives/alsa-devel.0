From: Johannes Kroll <j-kroll@gmx.de>
Subject: Re: Alsa Driver Scarlett
Date: Tue, 16 Sep 2014 16:10:02 +0200
Message-ID: <20140916161002.714e7667@sampi>
References: <54148F1B.2010608@gmail.com> <20140916152227.53556d96@sampi>
 <20140916134925.GE17677@x1-orm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 04FED265151
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 16:10:04 +0200 (CEST)
Received: from sampi ([178.24.34.36]) by mail.gmx.com (mrgmx103) with ESMTPSA
 (Nemesis) id 0LymjL-1YR8Kj2rXr-0164QR for
 <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 16:10:02 +0200
In-Reply-To: <20140916134925.GE17677@x1-orm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 16 Sep 2014 15:49:25 +0200
Orm Finnendahl <orm.finnendahl@selma.hfmdk-frankfurt.de> wrote:

> Am Dienstag, den 16. September 2014 um 15:22:27 Uhr (+0200) schrieb Johannes Kroll:
> > 
> > I guess I'll need to find the time to port the patch to a recent kernel
> > when I upgrade, unless someone else does it first.
> 
> The patch still works on our recent kernels (we are on debian testing
> with a 3.14-2 kernel), atm there is no porting necessary. I can also
> confirm that the driver has no known issues on our systems (we use a
> couple of Scarlett 18i20 in different configurations). It would be
> great, though if the patch could get integrated into alsa. At the
> moment it is quite painful for our students with linux laptops as they
> have to reapply the patch on every upgrade.

Oh, I see. I'm all for integrating this patch into mainline. But I have
never done such a thing, so I don't know how much effort it would be. I
guess it would be a simple thing to do for a routine Alsa developer. 
Anyone? :]
