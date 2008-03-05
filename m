From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Application doing forward/rewind
Date: Wed, 5 Mar 2008 14:44:15 +0530
Message-ID: <010C7BAE6783F34D9AC336EE5A01A0880575F758@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from calf.ext.ti.com (calf.ext.ti.com [198.47.26.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 1247A103824
	for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2008 10:15:31 +0100 (CET)
Content-class: urn:content-classes:message
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
Cc: suresh.raj@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

 

I am new to ALSA framework and currently working on an embedded
platform. My ALSA driver works fine with APLAY and ARECORD utilities,
which are coming along with the alsa-utils package. But they don't
support forward and rewind. I wrote my own app for the same but the APIs
are returning me 0, although some frames have been forwarded.

 

I searched a lot for some simple command line based audio player which
can provide me this sort of functionality but I could not find one. Can
someone help? If I have missed something, please let me know.

 

Thanks & Regards,

Anuj Aggarwal
