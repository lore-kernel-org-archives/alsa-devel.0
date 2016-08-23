From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v5 1/2] amidi: add delay option
Date: Tue, 23 Aug 2016 13:46:37 +0200
Message-ID: <ea34bd6e-eacb-c8ea-4452-f74afb7a8886@ladisch.de>
References: <20160815163734.17658-1-eu@felipetonello.com>
 <20160815163734.17658-2-eu@felipetonello.com>
 <5b064978-df48-23fa-26e1-89f9ed1843ff@ladisch.de>
 <1e733023-d7e8-a4ac-3b27-4bdb5a659418@felipetonello.com>
 <6bc1bbb7-37ea-8d23-875b-3472ec131463@ladisch.de>
 <380e9e0d-2d59-d814-062e-ca217fe78c09@felipetonello.com>
 <f24f99c5-1344-6b3d-8062-7cf905819bc6@ladisch.de>
 <44d334ff-1ed3-ec58-7f31-93fabf1b10ed@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 878B8266195
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 13:46:38 +0200 (CEST)
In-Reply-To: <44d334ff-1ed3-ec58-7f31-93fabf1b10ed@felipetonello.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Felipe Ferreri Tonello <eu@felipetonello.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Felipe Ferreri Tonello wrote:
> Why 320 =B5s for any byte not yet sent?

31250 baud; 10 bits per byte.


Regards,
Clemens
