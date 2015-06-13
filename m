From: Luka Karinja <luka.karinja@gmail.com>
Subject: Re: writing an alsa driver
Date: Sat, 13 Jun 2015 13:47:13 +0000 (UTC)
Message-ID: <loom.20150613T153708-781@post.gmane.org>
References: <20150527085440.GA4445@dellaz> <1432752116.8235.25.camel@loki>
 <20150527201320.GA309@asus> <1432812668.2726.18.camel@loki>
 <20150528125325.GA418@asus> <1432819294.2726.33.camel@loki>
 <20150528191721.GA608@asus> <1432892521.2732.14.camel@loki>
 <20150529131753.GA339@asus> <1433156768.2642.21.camel@loki>
 <20150608084951.GA7512@dellaz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id B38FF260420
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 15:50:07 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Z3loz-0000wL-JJ
 for alsa-devel@alsa-project.org; Sat, 13 Jun 2015 15:50:05 +0200
Received: from server.bazdara.com ([84.255.206.229])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 15:50:05 +0200
Received: from luka.karinja by server.bazdara.com with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Sat, 13 Jun 2015 15:50:05 +0200
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

Hey guys i have a T100TAF which also has z3735f & rt5648 and 
watching your development.

On the T100TA wich has the Z3740 and rt5645 a new /var/lib/alsa/asound.state
was needed to get the sound working.
It was making cracking sounds without it (saw in your previous post)
found here:
https://raw.githubusercontent.com/AdamWill/baytrail-m/master/alsa/t100_B.state

Eagerly following the development and sorry for noob post.
