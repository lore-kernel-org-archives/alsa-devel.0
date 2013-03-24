From: xiphmont@xiph.org
Subject: Re: [alsa-devel] libao problem (Re: No dmix/dsnoop on
 Intel ICH4/5 by default?)
Date: Sun, 24 Mar 2013 15:43:37 -0400
Message-ID: <CACrD=+8GwH6Euza1WrsKuuav=JPE5wbLMZAFQZHajKU3P0E7xA@mail.gmail.com>
References: <50F6FF00.7020706@gmail.com> <50F71312.1000009@ladisch.de>
	<50F7D0E3.3020401@gmail.com> <50F7EAA1.7040504@ladisch.de>
	<50F7F23C.4070006@gmail.com>
	<CACrD=+9THyqQKPj_V6Oeg1FaJwj8CRZ1YC+8SxFqR_bGbmpDGg@mail.gmail.com>
	<514F36F6.8080806@gmail.com>
	<CACrD=+_whofChWJU+hVR3opb_baHvTjqmLzWrbQAqu9r08GCPQ@mail.gmail.com>
	<514F4B0C.8020309@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <vorbis-dev-bounces@xiph.org>
In-Reply-To: <514F4B0C.8020309@ladisch.de>
List-Unsubscribe: <http://lists.xiph.org/mailman/listinfo/vorbis-dev>,
	<mailto:vorbis-dev-request@xiph.org?subject=unsubscribe>
List-Archive: <http://lists.xiph.org/pipermail/vorbis-dev>
List-Post: <mailto:vorbis-dev@xiph.org>
List-Help: <mailto:vorbis-dev-request@xiph.org?subject=help>
List-Subscribe: <http://lists.xiph.org/mailman/listinfo/vorbis-dev>,
	<mailto:vorbis-dev-request@xiph.org?subject=subscribe>
Sender: vorbis-dev-bounces@xiph.org
Errors-To: vorbis-dev-bounces@xiph.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, vorbis-dev@xiph.org, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

> The SND_PCM_NO_AUTO_* flags are there for exactly this reason:
> http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#ga64fa40b556374dabe40d4874242fee19

Ahhh, very good. Yes, I can improve the situation given these flags.

Monty
