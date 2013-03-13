From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to send non-SysEx system messages via ALSA?
Date: Wed, 13 Mar 2013 15:57:44 +0100
Message-ID: <514093E8.90005@ladisch.de>
References: <8E4C156DA5797D418DBFADFD8CE655A422BA54AFBB@HE113481.emea1.cds.t-internal.com>
 <513B90A9.7070309@gmail.com> <513BA324.8090109@ladisch.de>,
 <CAPbw_hzj9oR=QT-7F80ALGj4LCa=io+myC-ne8rctSPU07H=kg@mail.gmail.com>
 <8E4C156DA5797D418DBFADFD8CE655A422BA54AFC9@HE113481.emea1.cds.t-internal.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 3EDCE261737
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 15:57:48 +0100 (CET)
In-Reply-To: <8E4C156DA5797D418DBFADFD8CE655A422BA54AFC9@HE113481.emea1.cds.t-internal.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joerg-Cyril.Hoehle@t-systems.com
Cc: alsa-devel@alsa-project.org, gabrbedd@gmail.com
List-Id: alsa-devel@alsa-project.org

Joerg-Cyril.Hoehle@t-systems.com wrote:
> However, my current knowledge does not allow me to infer when to open
> rawmidi and when the seq interface.

Always use seq.


Regards,
Clemens
