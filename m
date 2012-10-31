From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Query about alsa ucm (use case manager) config files
Date: Wed, 31 Oct 2012 18:29:32 +0530
Message-ID: <1351688372.28030.18.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EEA5261654
 for <alsa-devel@alsa-project.org>; Wed, 31 Oct 2012 13:49:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lrg <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel <alsa-devel@alsa-project.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,
   I am just curious to know if there is any centralized repository for
alsa use case manager configuration files. I tried searching and could
only find alsa-ucm-conf.git repo at alsa project git server, which is
actually an empty repo!

How people share/reuse ucm configuration files for a specific codec?
In near future, I will be developing few ucm configuration files for
some codecs and wish to share them with rest of the world. I think even
though ucm configs are board/machine specific, it makes sense to share
them. Is there any other, more visible place to put these config files
than board specific distributions?
