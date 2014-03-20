From: Leonardo Gabrielli <l.gabrielli@univpm.it>
Subject: twl4030 latency update
Date: Thu, 20 Mar 2014 12:13:14 +0100
Message-ID: <532ACD4A.3080508@univpm.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id C345E2650C0
 for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2014 12:13:20 +0100 (CET)
Received: by mail-wg0-f48.google.com with SMTP id l18so477599wgh.7
 for <alsa-devel@alsa-project.org>; Thu, 20 Mar 2014 04:13:19 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: peter.ujfalusi@ti.com
Cc: Edgar Berdahl <eberdahl@ccrma.Stanford.EDU>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear Peter,
I was investigating on TWL4030 high playback latency and stumbled in an =

old thread started by Edgar =

http://mailman.alsa-project.org/pipermail/alsa-devel/2011-October/045173.ht=
ml =

where I read this is related to McBSP2 buffer length
Recent kernels seems to have the same behavior (I have a debian =

beagleboardxM with 3.13.3-armv7-x10)
Did you manage to get a fix to this problem? Would it be possible?

Regards

Leonardo

-- =


Dr. Leonardo Gabrielli, PhD student
A3Lab - Dept. Information Engineering
Universit=E0 Politecnica delle Marche
via Brecce Bianche 12, 60131, Ancona, Italy
Skype: leonardo.gabrielli
Web: a3lab.dii.univpm.it/people/leonardo-gabrielli =

<http://a3lab.dii.univpm.it/people/leonardo-gabrielli>
