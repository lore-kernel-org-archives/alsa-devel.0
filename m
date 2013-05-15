From: Jordi Mallach <jordi@debian.org>
Subject: Debian alsa-lib patches
Date: Wed, 15 May 2013 18:58:04 +0200
Message-ID: <1368637087-28860-1-git-send-email-jordi@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tempesta.oskuro.net (tempesta.oskuro.net [92.243.30.96])
 by alsa0.perex.cz (Postfix) with ESMTP id A46632616AB
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 18:58:30 +0200 (CEST)
Received: from penyagolosa.oskuro.net (169.219.14.37.dynamic.jazztel.es
 [37.14.219.169])
 by tempesta.oskuro.net (Postfix) with ESMTPSA id 7B241624FE
 for <alsa-devel@alsa-project.org>; Wed, 15 May 2013 18:58:25 +0200 (CEST)
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

As previously discussed, I'm posting all Debian patches against alsa-oss
that were pending upstreaming.

Thanks,
Jordi

[PATCH 1/3] Fix path to libaoss.so.
[PATCH 2/3] Show a warning if the alsa wrapper failed.
[PATCH 3/3] Add AM_MAINTAINER_MODE([enable]) to configure.in.
