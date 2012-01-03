From: Ricardo Barbosa <spiderslack@yahoo.com.br>
Subject: question application playback
Date: Tue, 3 Jan 2012 04:23:36 -0800 (PST)
Message-ID: <1325593416.22411.YahooMailNeo@web161301.mail.bf1.yahoo.com>
Reply-To: Ricardo Barbosa <spiderslack@yahoo.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm12.bullet.mail.bf1.yahoo.com (nm12.bullet.mail.bf1.yahoo.com
	[98.139.212.171]) by alsa0.perex.cz (Postfix) with SMTP id 2F5102470B
	for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2012 13:25:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all.


I am new to development using the alsa API and follow the link code http://=
equalarea.com/paul/alsa-audio.html

insert the following code.

=A0FILE=A0*fp;
=A0fp=A0=3D=A0fopen("file.mp3",=A0"r");
=A0fclose(fp);

and changed variable buf=A0by the variable fp, but by running the file file=
.mp3 he does not play according to the way it interferes with the function =
snd_pcm_writei ? someone could help me in developing this playback, I thank

Regards.
