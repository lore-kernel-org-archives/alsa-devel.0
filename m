From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsa-info.sh was broken recently
Date: Fri, 19 Sep 2014 11:40:06 +0200
Message-ID: <541BF9F6.4080801@perex.cz>
References: <1411081240.467539855@f39.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id D78862619F7
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 11:40:07 +0200 (CEST)
Received: from server.perex-int.cz (server.perex-srv.cz [172.16.0.20])
 by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id A04D2149E8A
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 11:40:07 +0200 (CEST)
Received: from t540.localdomain (localhost [127.0.0.1])
 by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
 3090B84F37
 for <alsa-devel@alsa-project.org>; Fri, 19 Sep 2014 11:40:07 +0200 (CEST)
In-Reply-To: <1411081240.467539855@f39.i.mail.ru>
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

Dne 19.9.2014 v 01:00 Sergey napsal(a):
> Hello.
> 
> Something was broken recently.
> 
> http://www.alsa-project.org/alsa-info.sh leads to Error 404.
> 
> As well as http://www.alsa-project.org/alsa-info.sh.changelog
> 
> It breaks many tutorials and documentation references, e.g.:
> http://www.kernel.org/doc/Documentation/sound/alsa/HD-Audio.txt
> 
> It also breaks the alsa-info.sh script itself attempting to update from that url.

Thanks. Fixed now.

				Jaroslav


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
