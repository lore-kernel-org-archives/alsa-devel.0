From: "Klaus Schulz" <kls.schlz@googlemail.com>
Subject: Automatic assignment/configuration of model-id?
Date: Thu, 30 Oct 2008 10:02:25 +0100
Message-ID: <d9690f190810300202l2ba7588j91823da236d4b65d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 84B2A246B0
	for <Alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 10:02:27 +0100 (CET)
Received: by yx-out-1718.google.com with SMTP id 36so258255yxh.2
	for <Alsa-devel@alsa-project.org>; Thu, 30 Oct 2008 02:02:26 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi gents.

To take full advantage of the driver I need to assign the right model option
to the module
- as far as I understand - manually.

Is there a way to automatically assign the "model=" option to the driver
module.

If not, how is a "normal" user supposed to configure the proper model-id to
be able to get
access to the full feature-set of the particular soundcard?

Background: The manual configuration is not known to many people. And many
people seem to get quite annoyed about the lack of functionality caused by a
generic driver.

THX.

Cheers
Klaus
