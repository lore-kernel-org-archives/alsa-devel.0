From: asd <asd@marian1000.go.ro>
Subject: On patch_realtek.c can' sent command to the codec via
Date: Mon, 02 Jun 2014 11:27:33 +0300
Message-ID: <3098159.EDPXMlQUDC@marian1000.go.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from marian1000.go.ro (5-14-230-222.residential.rdsnet.ro
 [5.14.230.222]) by alsa0.perex.cz (Postfix) with ESMTP id 34EE82610A6
 for <Alsa-devel@alsa-project.org>; Mon,  2 Jun 2014 10:27:35 +0200 (CEST)
Received: from localhost ([127.0.0.1] helo=marian1000.go.ro)
 by marian1000.go.ro with esmtp (Exim 4.82)
 (envelope-from <asd@marian1000.go.ro>) id 1WrNag-00014y-9g
 for Alsa-devel@alsa-project.org; Mon, 02 Jun 2014 11:27:34 +0300
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi
On patch_realtek.c can' sent command to the codec via command 
snd_hda_codec_write. 
Suppose to be entire module useless and hda-intel module to be a active.
