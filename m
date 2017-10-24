From: "Gou, Kylin" <Gou.Kylin@knowles.com>
Subject: how to dynamic link one cpu dai to codec dai?
Date: Tue, 24 Oct 2017 01:00:51 +0000
Message-ID: <352A1A93162DB84DB270FE53F1D93F749CFA47AF@KMVEX001.knowles.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001d2b01.pphosted.com (mx0b-001d2b01.pphosted.com
 [148.163.159.136])
 by alsa0.perex.cz (Postfix) with ESMTP id D4401266A0C
 for <alsa-devel@alsa-project.org>; Tue, 24 Oct 2017 03:00:55 +0200 (CEST)
Received: from pps.filterd (m0088670.ppops.net [127.0.0.1])
 by mx0b-001d2b01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9O0wASJ012055
 for <alsa-devel@alsa-project.org>; Mon, 23 Oct 2017 20:00:54 -0500
Received: from owa03.knowles.com ([205.167.202.105])
 by mx0b-001d2b01.pphosted.com with ESMTP id 2dr121t0a4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
 for <alsa-devel@alsa-project.org>; Mon, 23 Oct 2017 20:00:54 -0500
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Sir,

I registered 2 codec dai and 1 cpu dai . However , I want to link cpu dai to different codec dai , can we dynamic link cpu dai to each codec dai? I didn't find any document for it.

Thanks,
Kylin

******************************* IMPORTANT MESSAGE ******************************
This transmission may contain information that is privileged, confidential
and/or exempt from disclosure under applicable law. If you are not the intended
recipient, you are hereby notified that any disclosure, copying, distribution,
or use of the information contained herein (including any reliance thereon) is
STRICTLY PROHIBITED. If you received this transmission in error, please
immediately contact the sender and destroy the material in its entirety, whether
in electronic or hard copy format. Thank you.
********************************************************************************
